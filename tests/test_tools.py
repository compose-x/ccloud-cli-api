#   -*- coding: utf-8 -*-
#  Copyright (C) 2021 John "Preston" Mille <john@compose-x.io>
#  SPDX-License-Identifier: GPL-2.0


from ccloud_cli_api.tools import replace_string_in_dict_values


def test_replace_dict_values():
    input = {
        "test": "thevalue",
        "test2": "something without the value",
        "test3": "something with thevalue",
    }
    replace_string_in_dict_values(input, "thevalue", "TOTO")
    print(input)
    new = replace_string_in_dict_values(input, "TOTO", "TATA", True)
    print(new, input)
