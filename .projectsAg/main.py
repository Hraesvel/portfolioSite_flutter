#!/usr/bin/python3
"""
script that fetches a google sheets of projects and convert it into a json.
"""
import json
import os.path
import pickle

from google.auth.transport.requests import Request
from google_auth_oauthlib.flow import InstalledAppFlow
# If modifying these scopes, delete the file token.pickle.
from googleapiclient.discovery import build

import boto3

from model.projects import Frontend, Backend
from model.experiences import Experiences

SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']

# The ID and range of a sample spreadsheet.
SPREADSHEET_ID = {'projects': '1qZiNdWzN2YFqzTkGktkv3Zvny9qm3uBd4tkkJpzSrCc',
                  'experiences': '1dBaNi1avZqFcKqVFsrP1N3gFIOvJSYCYEqZ7ES7ylgw'}
RANGE_NAME = 'A1:J'
CRED_PATH = '../../../sheetsApiCreds/credentials.json'
TOKEN_PATH = '../../../sheetsApiCreds/token.json'
PROJECTS_JSON = ['../assets/projects/projects.json', './projects.json']
EXP_JSON = ['../assets/experiences.json', './experiences.json']


# PROJECTS_JSON = './projects.json'

def fetch_from_sheets(service, sheet_name):
    return service.values().get(spreadsheetId=SPREADSHEET_ID[sheet_name], range=RANGE_NAME,
                                majorDimension="ROWS").execute()


def main():
    creds = None

    if os.path.exists(TOKEN_PATH):
        with open(TOKEN_PATH, "rb") as token:
            creds = pickle.load(token)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                CRED_PATH, SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open(TOKEN_PATH, 'wb') as token:
            pickle.dump(creds, token)

    service = build("sheets", 'v4', credentials=creds, )

    sheet = service.spreadsheets()
    fetch_projects(sheet)
    fetch_experiences(sheet)


def fetch_projects(sheet):
    result = sheet.values().get(spreadsheetId=SPREADSHEET_ID['projects'], range=RANGE_NAME,
                                majorDimension="ROWS").execute()
    values = result.get('values', [])
    fields = values[0]
    projects = {"frontend": [], "backend": []}
    if not values:
        print('No data found.')
    else:
        for row in values[1:]:
            d = dict(zip(fields, row))
            if d['show'] == 'FALSE':
                pass
            if d["type"] == "frontend":
                projects['frontend'].append(Frontend(**d).toDict())
            else:
                projects['backend'].append(Backend(**d).toDict())
    # print(projects["frontend"])
    """ Sort project by there priority & name field"""
    projects["frontend"] = sorted(projects["frontend"], key=lambda i: (i["priority"], i['name']), reverse=True)
    projects["backend"] = sorted(projects["backend"], key=lambda i: (i["priority"], i['name']), reverse=True)
    # print(projects["frontend"])
    """write as bytes using 'wb+' """
    for pjson in PROJECTS_JSON:
        with open(pjson, 'wb+') as file:
            file.write(json.dumps(projects, indent=2, ensure_ascii=False).encode('utf8'), )


def fetch_experiences(sheet):
    result = sheet.values().get(spreadsheetId=SPREADSHEET_ID['experiences'], range=RANGE_NAME,
                                majorDimension="ROWS").execute()
    values = result.get('values', [])
    fields = values[0]
    experience = {'count': 0, 'data': []}
    if not values:
        print('Job experience data found.')
    else:
        for row in values[1:]:
            d = dict(zip(fields, row))
            experience['data'].append(Experiences(**d).toDict())

    experience['count'] = len(experience['data'])

    """ Sort project by there priority & name field"""
    # print(projects["frontend"])
    """write as bytes using 'wb+' """
    for job_exp in EXP_JSON:
        with open(job_exp, 'wb+') as file:
            dump = json.dumps(experience, indent=2, ensure_ascii=False).encode('utf8')
            file.write(dump)


if __name__ == "__main__":
    main()
    s = boto3.session.Session()
    s3 = s.client('s3')

    with open('./experiences.json', 'rb') as file:
        print(s3.put_object(Bucket="msmith-portfolio", Key='public/experiences.json', Body=file.read()))

    with open('./projects.json', 'rb') as file:
        print(s3.put_object(Bucket="msmith-portfolio", Key='public/projects.json', Body=file.read()))
