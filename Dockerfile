FROM registry.access.redhat.com/ubi8-minimal:latest
RUN microdnf install -y bash dnf jq glibc-devel libffi-devel make curl && \
    dnf -y -q module reset python39 && \
    dnf -y -q module enable python39:3.9 && \
    dnf -y -q install python39 python39-devel python39-setuptools python39-pip && \
    ln -s /usr/bin/pip3.9 /usr/bin/pip && \
    ln -s /usr/bin/python3.9 /usr/bin/python && \
    /usr/bin/pip install pynacl
# also include checkIfSecretExists.sh but don't use it by default (optional entrypoint)
COPY delete.* checkIfSecretExists.* generate.* /
ENTRYPOINT [ "/generate.sh" ]
