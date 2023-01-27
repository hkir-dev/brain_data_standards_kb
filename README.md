# Brain Data Standards KB
A repository for the Brain Data Standards knowledge graph.

## Build and Run
To build the project clone project to your computer and run the following command in the project root folder to build the Docker image.

```
docker build -t bds/kb-prod:standalone .
```

To run the Docker image:
```
docker run -d -p:7473:7474 -p 7686:7686 -v $PWD/backup:/backup --env-file ./env.list bds/kb-prod:standalone
```

On startup KB will automatically load the backup data.

### Debug Running Container _[Optional]_
To find the running container's id, run:
```
docker ps
```

Copy the container id and then run:
```
docker logs --follow CONTAINER_ID
```

In the logs you should see `Restore KB from given backup` and `Started.` comments. Please [create a issue](https://github.com/hkir-dev/brain_data_standards_kb/issues/new) to report any abnormal behavior.

## Browse KB
Open http://localhost:7473/browser/ in your browser. You don't need to provide any `Username` or `Password`, so you can left those fields empty.

On the top left corner click the `Database` icon. Under `Node Labels` sections, you can see labels of the entities. Click one of the labels and start browsing.
