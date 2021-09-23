#   -*- coding: utf-8 -*-
#  Copyright (C) 2021 John "Preston" Mille <john@compose-x.io>
#  SPDX-License-Identifier: GPL-2.0

from ccloud_cli_api.aws_secret import lambda_handler


def handler(event, context):
    return lambda_handler(event, context)
