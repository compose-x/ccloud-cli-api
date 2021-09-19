ARG CCLOUD_IMAGE=public.ecr.aws/ews-network/confluentinc/ccloud-cli:v1.39.1
ARG PYTHON_IMAGE=public.ecr.aws/compose-x/python:3.8

FROM $CCLOUD_IMAGE as ccloud

FROM $PYTHON_IMAGE as pythonbuild
WORKDIR /opt/ccloud_cli_api
RUN python -m pip install -U pip poetry
COPY ccloud_cli_api pyproject.toml LICENSE MANIFEST.in README.rst /opt/ccloud_cli_api/
RUN poetry build

FROM $PYTHON_IMAGE
ENV PATH=$PATH:/opt/ccloud
COPY --from=ccloud /opt/ccloud /opt/ccloud
COPY --from=pythonbuild /opt/ccloud_cli_api/dist/*.whl /tmp
RUN pip install -U pip /tmp/*.whl

ONBUILD RUN python -c "import ccloud_cli_api; print(ccloud_cli_api.__version__)"

ENTRYPOINT ["python"]
CMD ["-m", "ccloud_cli_api.ccloud_cli_api"]
