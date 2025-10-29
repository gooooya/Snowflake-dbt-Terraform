COPY INTO "${to_database}"."${to_schema}"."${target_table}"
FROM @"${from_database}"."${from_schema}"."${stage_name}"${stage_sub_dir}
FILE_FORMAT = (FORMAT_NAME = "${to_database}"."${to_schema}"."${target_format_name}");