# Use the official Ubuntu base image
FROM ubuntu:latest

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update the package listing, install packages
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    apt-get install -y openjdk-11-jdk && \
    pip3 install jupyter && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*




# Set the working directory in the container
WORKDIR /workdir

# Copy the custom README.md into the working directory
COPY README.md /workdir

RUN mkdir lab3
COPY lab_03.ipynb /workdir/lab3
COPY lab3_config.sh /workdir/lab3

# Command to run Jupyter notebook
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]




# Add a custom welcome message with green hash symbols on the top and bottom
RUN echo -e '\necho -e "\n\033[1;32m################################################################\033[0m"\n' \
         'echo -e "\033[0m                                             \033[0m"\n' \
         'echo -e "\033[0m  Welcome to your custom Docker container for the module  \033[0m"\n' \
         'echo -e "\033[0m  Programming For Big Data.  \033[0m"\n' \
         'echo -e "\033[0m  \033[0m"\n' \
         'echo -e "\033[0m  You can run the Jupyter Notebook by running the command:                              \033[0m"\n' \
         'echo -e "\033[0m \033[0m"\n' \
         'echo -e "\033[0m  >    jupyter lab --ip 0.0.0.0 --no-browser --allow-root   \033[0m"\n' \
         'echo -e "\033[0m                                              \033[0m"\n' \
         'echo -e "\033[0m  It can then be accessed on 'localhost:8888' on your browser.                                            \033[0m"\n' \
         'echo -e "\033[0m  (The required token is in the output of                                            \033[0m"\n' \
         'echo -e "\033[0m    the jupyter notebook command)                                            \033[0m"\n' \
         'echo -e "\033[1;32m################################################################\033[0m\n"' >> /root/.bashrc




# Set the default command to launch bash
CMD ["bash"]



# Expose the port Jupyter Notebook will be accessible on
EXPOSE 8888

# Set back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=
