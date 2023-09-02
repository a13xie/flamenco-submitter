import bpy
import json

import sys
argv = sys.argv

name = "smt"

bpy.ops.flamenco.fetch_job_types()

if "preview" in argv:
  print("Rendering preview")
  bpy.data.scenes["Scene"].render.resolution_percentage = 25
  bpy.data.scenes["Scene"].cycles.samples = bpy.data.scenes["Scene"].cycles.samples // 4
  name += "-preview"
else:
  print("Doing full render")

bpy.ops.flamenco.submit_job(job_name=name, ignore_version_mismatch=False)
