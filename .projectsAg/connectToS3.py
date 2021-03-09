import csv

import boto3

AWS_CRED = "../../../awsCreds/rootkey.csv"
BUCKET = "msmith-portfolio"


class S3:
    client = None
    __keys = {}

    def __init__(self):
        with open(AWS_CRED) as cred:
            reader = csv.reader(cred)
            for row in reader:
                [k, *v] = row[0].split("=")
                self.__keys[k] = v[0]

    def connect(self):
        try:
            self.client = boto3.client('s3',
                                       aws_access_key_id=self.__keys["AWSAccessKeyId"],
                                       aws_secret_access_key=self.__keys["AWSSecretKey"]
                                       )

            result = (self.client.get_bucket_acl(Bucket="msmith-portfolio"))
            print(result)

        except Exception as e:
            print(e)

    def list_buckets(self):
        print(self.client.list_buckets()["Buckets"])


if __name__ == "__main__":
    s3_client = S3()
    s3_client.connect()
    s3_client.list_buckets()
