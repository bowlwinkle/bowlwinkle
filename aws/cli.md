# CLI Cheat Sheet

## API Gateway

Download OpenAPI
```shell
aws apigateway get-export --parameters extensions='apigateway' --rest-api-id $1 --stage-name $2 --export-type swagger $3
```

Query API Gateway and list as table
```shell
aws apigateway get-rest-apis --query "items[?endpointConfiguration.types[0]=='EDGE'].{name:name, id:id}" --output table
```

## Credentials & Account Details

Account Details
```shell
aws sts get-caller-identity
```

Show current account
```shell
aws sts get-caller-identity --query Account --output text
```

Assume role based on AWS profile
```shell
aws sts get-caller-identity --profile $1
```