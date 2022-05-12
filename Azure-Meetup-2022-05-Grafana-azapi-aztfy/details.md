# aztfy

## Pre-Requisites

* Install aztfy
  * `go install github.com/Azure/aztfy@latest`

## CLI

```bash
# interactive
aztfy -o <DIRECTORY> <YOUR_RG>
# batch
aztfy -o <DIRECTORY> -b -m demo.json <YOUR_RG>
```

## demo.json

```json
{
    "<azure resource id1>": "<terraform resource type1>.<terraform resource name>",
    "<azure resource id2>": "<terraform resource type2>.<terraform resource name>",
    ...
}
```
