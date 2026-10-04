.PHONY: diagrams

# The renderer is pinned by digest so that the same .puml always produces the
# same .svg: PlantUML lays out text with the fonts inside the image.
PLANTUML_IMAGE := plantuml/plantuml:1.2025.4@sha256:227c418ce3811b3bfd48e022922af35839914d606d5ea1c8a4137d77d58d482c
PLANTUML_RUN   := docker run --rm \
	-v "$(CURDIR)":/src -w /src \
	--user "$$(id -u):$$(id -g)" \
	-e HOME=/tmp \
	-e JAVA_TOOL_OPTIONS=-Duser.home=/tmp \
	$(PLANTUML_IMAGE)

# Render every docs/**/*.puml to an .svg next to it. Commit both files.
diagrams:
	$(PLANTUML_RUN) -tsvg -nometadata -failfast2 "docs/**.puml"
