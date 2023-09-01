import bpy
import json

import sys
argv = sys.argv
argv = argv[argv.index("--") + 1:]  # get all args after "--"

bpy.ops.flamenco.fetch_job_types()

job_types_json = json.loads(bpy.data.scenes["Scene"].flamenco_available_job_types_json)
job_types = []
for entry in job_types_json["job_types"]:
    job_types.append(entry["name"])

if argv[0] in job_types:
    print("Nice, I found this job type!")

#bpy.data.scenes["Scene"].flamenco_job_type
