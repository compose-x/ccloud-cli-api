ARG CCLOUD_IMAGE=public.ecr.aws/ews-network/confluentinc/ccloud-cli:1.43.1
ARG PYTHON_IMAGE=public.ecr.aws/compose-x/python:3.8
ARG LAMBDA_PYTHON=public.ecr.aws/lambda/python:3.8

FROM $CCLOUD_IMAGE as ccloud

FROM $PYTHON_IMAGE as pythonbuild
WORKDIR /opt/ccloud_cli_api
RUN python -m pip install -U pip poetry
COPY . /opt/ccloud_cli_api/
RUN poetry build

FROM $PYTHON_IMAGE
ENV PATH=$PATH:/opt/ccloud
COPY --from=ccloud /opt/ccloud /opt/ccloud
COPY --from=pythonbuild /opt/ccloud_cli_api/dist/*.whl /tmp
RUN pip install -U pip /tmp/*.whl

RUN python -c "import ccloud_cli_api; print(ccloud_cli_api.__version__)"


FROM $LAMBDA_PYTHON
ENV PATH=$PATH:/opt/ccloud
COPY --from=ccloud /opt/ccloud /opt/ccloud
COPY --from=pythonbuild /opt/ccloud_cli_api/dist/*.whl /tmp
RUN pip install -U pip /tmp/*.whl
COPY function.py ${LAMBDA_TASK_ROOT}
WORKDIR /tmp
CMD [ "function.handler" ]
