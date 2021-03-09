import json
import os

import boto3
from botocore.exceptions import ClientError

# from email.mime.multipart import MIMEMultipart
# from email.mime.text import MIMEText
# from email.mime.application import MIMEApplication

region = os.environ['Region']


def send_mail(msg):
    client_ses = boto3.client('ses', region)

    try:
        verify = client_ses.verify_email_address(EmailAddress=msg)
        response = client_ses.send_email(
            Source='contactme@msmith.online',
            Destination={
                'ToAddresses': [],
                'CcAddresses': [],
                'BccAddresses': []
            },
            Message={
                'Subject': {'Data': f"from {msg['reply_address']}"},
                'Body': {'Text': {'Data': msg['body']}}},
            ReplyToAddresses=[msg['reply_address']],

        )
    except ClientError as e:
        output = e.response['Error']['Message']

    else:
        output = "Email sent! Message ID: " + response['MessageId']

    return output


def lambda_handler(event, context):
    # print(event)
    # print(event['reply_address'])

    print(send_mail(event))

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
