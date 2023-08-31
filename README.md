# flamenco-submitter
The goal of this project is to create a simple script to submit render jobs to Flamenco. Meant to be used in CI pipelines.

## Addon installation, setting the Flamenco server URL

```
bpy.ops.preferences.addon_install(filepath="/smt")
bpy.ops.preferences.addon_enable(module='flamenco')
bpy.context.preferences.addons['flamenco'].preferences['manager_url']
bpy.ops.wm.save_userpref()
```

## Fetch job types, set job settings, submit job

```
bpy.ops.flamenco.fetch_job_types()
bpy.data.scenes["Scene"].flamenco_available_job_types_json
bpy.data.scenes["Scene"].flamenco_job_type
bpy.data.scenes["Scene"].flamenco_job_settings
bpy.ops.flamenco.submit_job(job_name="smt", ignore_version_mismatch=False)
```


## Some other stuff I found in Flamenco's source code

```
configuration = flamenco.manager.Configuration(
    host = "http://flamenco.mcld.eu"
)
with flamenco.manager.ApiClient(configuration) as api_client:

	api_instance = jobs_api.JobsApi(api_client)
	smt = jobs_api.JobsApi(api_instance)
```
