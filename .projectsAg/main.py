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

SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']

# The ID and range of a sample spreadsheet.
SPREADSHEET_ID = '1qZiNdWzN2YFqzTkGktkv3Zvny9qm3uBd4tkkJpzSrCc'
RANGE_NAME = 'A1:J'
CRED_PATH = '../../../sheetsApiCreds/credentials.json'
TOKEN_PATH = '../../../sheetsApiCreds/token.json'
PROJECTS_JSON = ['../assets/projects/projects.json', './projects.json']

# PROJECTS_JSON = './projects.json'


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
    result = sheet.values().get(spreadsheetId=SPREADSHEET_ID, range=RANGE_NAME, majorDimension="ROWS").execute()

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


if __name__ == "__main__":
    main()
