import os
import yaml

root_path = os.path.dirname(os.path.abspath(__file__))

# module は単純に格納
modules = {}
# terragrunt は env ごとに格納
terragrunts = {"dev": {}, "prod": {}}

for dirpath, dirnames, filenames in os.walk(root_path):
    dirnames[:] = [d for d in dirnames if not d.startswith(".")]

    folder_name = os.path.basename(dirpath)
    rel_path = os.path.relpath(dirpath, root_path)

    # パス区切りを / に統一
    rel_path = rel_path.replace(os.sep, "/")

    # module 側: main.tf がある場合のみ
    if "main.tf" in filenames:
        modules[folder_name] = rel_path

    # terragrunt 側: terragrunt.hcl がある場合のみ
    if "terragrunt.hcl" in filenames:
        env_key = None
        for key in ["dev", "env", "prod"]:
            if key in rel_path.split("/"):  # os.sep → "/" に変更
                env_key = key
                break
        if env_key:
            terragrunts[env_key][folder_name] = rel_path
        else:
            terragrunts.setdefault("others", {})[folder_name] = rel_path

# value（パス）でソート
def sort_dict_by_value(d):
    sorted_dict = {}
    for k, v in sorted(d.items(), key=lambda x: x[1] if not isinstance(x[1], dict) else ""):
        if isinstance(v, dict):
            sorted_dict[k] = sort_dict_by_value(v)
        else:
            sorted_dict[k] = v
    return sorted_dict

modules_sorted = sort_dict_by_value(modules)
terragrunts_sorted = sort_dict_by_value(terragrunts)

output = {
    "module": modules_sorted,
    "terragrunt": terragrunts_sorted
}

yaml_path = os.path.join(root_path, "folders.yaml")
with open(yaml_path, "w", encoding="utf-8") as f:
    yaml.dump(output, f, allow_unicode=True, sort_keys=False)

print(f"YAML出力完了: {yaml_path}")
