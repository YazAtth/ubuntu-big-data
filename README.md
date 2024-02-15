# Ubuntu with Programming for Big Data

Created for the module programming for big data.

After downloading the image, copy and paste the following command to run the docker container:
```bash
docker run -it -p 8888:8888 ghcr.io/yazatth/ubuntu-big-data
```

Then run the command:
```bash
jupyter lab --ip 0.0.0.0 --no-browser --allow-root 
```
(Note: an authentication token will be outputted which you will need to copy)

Then use your browser to go to [http://localhost:8888/](http://localhost:8888/) and paste the authentication token into the text box to access Jupyter Lab.

**WARNING: Ensure to download any files you want to keep as closing the docekr container will delete all the files.**


## Notes

You can safely ignore this warning: 
```
WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
```

---

You may get the error below as hadoop won't overwrite the output folder.
```bash
ERROR streaming.StreamJob: Error Launching job : Output directory hdfs://localhost:9000/word_count/python_output already exists
```
This can be resolved by deleting the output folder like below:
```bash
!$HADOOP_HOME/bin/hdfs dfs -rm -r /word_count/python_output
```

---
Note: some filepaths may need to be changed depending on your use case. The provided `lab_03.ipynb` in this container uses `/workdir/lab3/` but the one from Brightspace uses `/content/`.

