# Use the official Ubuntu base image
FROM openjdk:11-jre-slim

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update the package listing, install packages
RUN apt-get update && \
    apt-get install -y curl vim wget software-properties-common ssh net-tools ca-certificates python3 python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas
RUN pip3 install jupyter && \
    pip3 install findspark pyarrow

RUN update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1

RUN curl -o spark.tgz https://archive.apache.org/dist/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz && \
    tar xf spark.tgz -C /opt/

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
 ENV SPARK_VERSION=3.3.1 \
 HADOOP_VERSION=3.3.2 \
 SPARK_HOME=/opt/spark-3.3.1-bin-hadoop3 \
 JAVA_HOME=/usr/local/openjdk-11 \
 PYTHONHASHSEED=1


    # Clean up
RUN apt-get clean && \
    rm -rf spark.tgz && \
    rm -rf /var/lib/apt/lists/*




# Set the working directory in the container (i dont think i need this because of the docker compose)
WORKDIR /project

# Copy the custom README.md into the working directory
COPY README.md /project

# not needed anymore (lab4 for testing spark functionality)
#RUN mkdir lab3
#COPY lab_03.ipynb /project/lab3
#COPY lab3_config.sh /project/lab3
RUN mkdir lab4
COPY lab_04.ipynb /project/lab4

# Command to run Jupyter notebook
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]



# broken so commented out, go find it in the readme
# Add a custom welcome message with green hash symbols on the top and bottom
# RUN echo -e '\n echo -e "\n\033[1;32m################################################################\033[0m"\n' \
#         'echo -e "\033[0m                                             \033[0m"\n' \
#         'echo -e "\033[0m  Welcome to your custom Docker container for the module  \033[0m"\n' \
#         'echo -e "\033[0m  Programming For Big Data.  \033[0m"\n' \
#         'echo -e "\033[0m  \033[0m"\n' \
#         'echo -e "\033[0m  You can run the Jupyter Notebook by running the command:                              \033[0m"\n' \
#         'echo -e "\033[0m \033[0m"\n' \
#         'echo -e "\033[0m  >    jupyter lab --ip 0.0.0.0 --no-browser --allow-root   \033[0m"\n' \
#         'echo -e "\033[0m                                              \033[0m"\n' \
#         'echo -e "\033[0m  It can then be accessed on 'localhost:8888' on your browser.                                            \033[0m"\n' \
#         'echo -e "\033[0m  (The required token is in the output of                                            \033[0m"\n' \
#         'echo -e "\033[0m    the jupyter notebook command)                                            \033[0m"\n' \
#         'echo -e "\033[1;32m################################################################\033[0m\n"' >> /root/.bashrc




# Set the default command to launch bash
CMD ["bash"]



# Expose the port Jupyter Notebook will be accessible on
EXPOSE 8484 

# Set back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=
