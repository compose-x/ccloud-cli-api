#   -*- coding: utf-8 -*-
#  Copyright (C) 2021 John "Preston" Mille <john@compose-x.io>
#  SPDX-License-Identifier: GPL-2.0


from ccloud_cli_api.tools import replace_string_in_dict_values


def test_replace_dict_values():
    input = {
        "test": "thevalue",
        "test2": "something without the value",
        "test3": "something with thevalue",
        "PASSWORD": "IHL9MrojaaQ7OMBPPliStIeFDkKSVxaCN73GDta3nap3t+qOIZgEuljxvche52Qt",
    }
    replace_string_in_dict_values(input, "thevalue", "TOTO")
    print(input)
    new = replace_string_in_dict_values(input, "TOTO", "TATA", True)
    print(new, input)
    replace_string_in_dict_values(
        input,
        "IHL9MrojaaQ7OMBPPliStIeFDkKSVxaCN73GDta3nap3t+qOIZgEuljxvche52Qt",
        "ABCD",
        False,
    )
    print(input)
    assert input["PASSWORD"] == "ABCD"
