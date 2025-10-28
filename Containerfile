FROM container-registry.oracle.com/os/oraclelinux:9-slim

# Install Oracle InstantClient and Python 3.13 from YUM
RUN microdnf install -y oracle-instantclient-release-23ai-el9 oracle-epel-release-el9 && \
    microdnf upgrade -y && \
    microdnf install -y oracle-instantclient-basic python3.13 python3.13-pip && \
    microdnf clean -y all

# Install Python Packages
# Doing so without a venv shaves off roughly 11 MiB from image size
RUN pip3.13 install --root-user-action ignore oracle-parquet-exporter && \
    pip3.13 cache purge

# Set oracle-parquet-exporter to run by default.
ENTRYPOINT [ "oracle-parquet-exporter" ]
