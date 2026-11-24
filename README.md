# ComfyUI (Docker)

## Run
```
docker compose up -d --build
```
Open http://localhost:8188

Logs: `docker compose logs -f`
Stop: `docker compose down`

## Folders
- `models/` — put weights here (`diffusion_models/`, `text_encoders/`, `vae/`, `checkpoints/`, `loras/`)
- `custom_nodes/` — ComfyUI-Manager is cloned here on first start
- `output/` — generated files
- `user/` — saved workflows and settings

## Notes
- Requires Docker Desktop (WSL2 backend) and a current NVIDIA driver.
- After installing nodes via Manager, restart: `docker compose restart`
- If Manager blocks an install with a security message, find its `config.ini` under `user/` and set `security_level = weak`, then restart.
- Update ComfyUI: `docker compose build --no-cache && docker compose up -d`
