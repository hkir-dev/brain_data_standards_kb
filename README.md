# Brain Data Standards KB
A repository for the Brain Data Standards knowledge graph.

## Build and Run
To build the project, clone project to your computer and run the following command in the project root folder:
```
docker build -t bds/kb-prod:standalone .
```

To run the built Docker image:
```
docker run -d -p:7473:7474 -p 7686:7686 -v $PWD/backup:/backup --env-file ./env.list bds/kb-prod:standalone
```

On startup KB will automatically load the backup data and you can start exploring the knowledge graph via your browser.

### _Debug Running Container [Optional]_
To ensure KB started successfully please follow the given steps.

To find the started Docker container's id, run:
```
docker ps
```

Copy the container id and then run:
```
docker logs --follow CONTAINER_ID
```

In the logs you should see `Restore KB from given backup` and `Started.` comments. Please [create an issue](https://github.com/hkir-dev/brain_data_standards_kb/issues/new) to report any abnormal behaviors.

## Browse KB
Open http://localhost:7473/browser/ in your browser. You don't need to provide any `Username` or `Password`, so you can left those fields empty.

On the top left corner click the `Database` icon. Under `Node Labels` sections you can find the labels of the KB entities. Click one of the labels and start browsing.
