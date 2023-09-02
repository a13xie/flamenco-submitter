import bpy
import json
import os

argv = sys.argv

name = os.environ.get('PROJECT_NAME')

bpy.ops.flamenco.fetch_job_types()

if os.environ.get('PREVIEW') is not None:
  print("Rendering preview")
  bpy.data.scenes["Scene"].render.resolution_percentage = 25
  bpy.data.scenes["Scene"].cycles.samples = bpy.data.scenes["Scene"].cycles.samples // 4
  name += "_preview"
else:
  print("Doing full render")

print(bpy.ops.flamenco.submit_job("INVOKE_DEFAULT", job_name=name))
