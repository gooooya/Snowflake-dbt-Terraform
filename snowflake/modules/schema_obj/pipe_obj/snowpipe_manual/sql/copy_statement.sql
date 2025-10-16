COPY INTO ${database}.${schema}.${target_table}
FROM @${database}.${schema}.${stage_name}
FILE_FORMAT = (FORMAT_NAME = '${database}.${schema}.${target_format_name}');