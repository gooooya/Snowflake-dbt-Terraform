COPY INTO {{ database }}.{{ schema }}.{{ target_table }}
FROM @{{ database }}.{{ schema }}.{{ stage_name }}
FILE_FORMAT = (TYPE = {{ target_format | replace("\"", "") }});
# ↑"がなければと大文字小文字どちらの入力でもよい模様