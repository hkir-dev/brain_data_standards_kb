# Brain Data Standards KB
A repository for the Brain Data Standards knowledge graph.

## Local Build and Run
To build the project, clone the project to your computer and run the following commands in the project root folder:
```
docker build -t bds/kb-prod:standalone .
```

To run the built Docker image:
```
docker run -d -p:7473:7474 -p 7686:7686 -v $PWD/backup:/backup --env-file ./env.list bds/kb-prod:standalone
```

At startup, KB automatically loads the backup data and you can start exploring the knowledge graph through your browser.

## DockerHub Based Run
Alternative to local approach, DockerHub image can be used:
```
docker run -d -p:7473:7474 -p 7686:7686 hkir/kb-prod:standalone
```

### _Debug Running Container [Optional]_
Please follow the given steps to make sure the KB starts successfully.

To find the ID of the started Docker container run:
```
docker ps
```

Copy the container ID and then run:
```
docker logs --follow CONTAINER_ID
```

You should see `Restore KB from given backup` and `Started.` in the logs. To report any abnormal behavior, please [create an issue](https://github.com/hkir-dev/brain_data_standards_kb/issues/new).

## Browse KB
Open http://localhost:7473/browser/ in your browser. You do not need to enter any `Username` or `Password`, so you can leave these fields blank.

Click the `Database` icon in the upper left corner . Under the `Node Labels` section, you can find the labels of the KB entities. Click on one of the labels and start browsing.
