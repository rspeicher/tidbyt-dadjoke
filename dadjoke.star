load("render.star", "render")
load("http.star", "http")
load("schema.star", "schema")

DELAY = 100

def main(config):
  url = "https://icanhazdadjoke.com"

  resp = http.get(url, headers={"user-agent": "tidbyt-dadjoke/1.0", "accept": "application/json"})
  json = resp.json()

  if resp.status_code != 200:
    fail("Failed to fetch joke")
    return

  title_font = "CG-pixel-3x5-mono"
  title_height = 7
  fact_height = 32 - title_height

  return render.Root(
    delay=DELAY,
    child=render.Column(
      expanded=True,
      children=[
        render.Box(
          height=title_height,
          color="#fff",
          child=render.Text("Dad jokes", font=title_font, color="#000")
        ),
        render.Marquee(
          scroll_direction="vertical",
          offset_start=fact_height,
          height=fact_height,
          width=64,
          child=render.Column(
            children=[
              render.WrappedText(json["joke"]),
            ]
          )
        )
      ]
    )
  )
