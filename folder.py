import os
import yaml
from collections import OrderedDict

# スクリプトのあるディレクトリを root とする
root_path = os.path.dirname(os.path.abspath(__file__))

modules = {}
terragrunts = {}

for dirpath, dirnames, filenames in os.walk(root_path):
    # .で始まるフォルダを無視
    dirnames[:] = [d for d in dirnames if not d.startswith(".")]

    folder_name = os.path.basename(dirpath)
    rel_path = os.path.relpath(dirpath, root_path)

    if any(f.endswith(".tf") for f in filenames):
        modules[folder_name] = rel_path
    if any(f.endswith(".hcl") for f in filenames):
        terragrunts[folder_name] = rel_path

# value（パス）順にソートした OrderedDict を普通の dict に変換
modules_sorted = {k: v for k, v in sorted(modules.items(), key=lambda x: x[1])}
terragrunts_sorted = {k: v for k, v in sorted(terragrunts.items(), key=lambda x: x[1])}

output = {
    "module": modules_sorted,
    "terragrunt": terragrunts_sorted
}

yaml_path = os.path.join(root_path, "folders.yaml")
with open(yaml_path, "w", encoding="utf-8") as f:
    yaml.dump(output, f, allow_unicode=True, sort_keys=False)

print(f"YAML出力完了: {yaml_path}")
