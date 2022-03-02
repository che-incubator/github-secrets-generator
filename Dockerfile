FROM registry.access.redhat.com/ubi8-minimal:8.5
RUN microdnf install -y bash dnf jq glibc-devel libffi-devel make curl && \
    dnf -y -q module reset python38 && \
    dnf -y -q module enable python38:3.8 && \
    dnf -y -q install python38 python38-devel python38-setuptools python38-pip && \
    ln -s /usr/bin/pip3.8 /usr/bin/pip && \
    /usr/bin/pip install pynacl
# also include checkIfSecretExists.sh but don't use it by default (optional entrypoint)
COPY delete.* checkIfSecretExists.* generate.* /
ENTRYPOINT [ "/generate.sh" ]
