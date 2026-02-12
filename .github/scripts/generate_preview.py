#!/usr/bin/env python3
"""
Generate SVG preview images for GNOME Terminal themes.
Creates a fastfetch-style preview with color palette circles and sample terminal content.

Usage:
    # Generate specific themes
    python3 generate_preview.py themes/nord-dark.sh themes/matrix-dark.sh

    # Generate all themes and update README
    python3 generate_preview.py --all --update-readme
"""

import argparse
import re
import sys
from pathlib import Path


def parse_rgb(rgb_str: str) -> tuple[int, int, int]:
    """Parse 'rgb(R,G,B)' string to tuple."""
    match = re.search(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)', rgb_str)
    if match:
        return int(match.group(1)), int(match.group(2)), int(match.group(3))
    return (128, 128, 128)


def rgb_to_hex(rgb: tuple[int, int, int]) -> str:
    """Convert RGB tuple to hex color."""
    return f"#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}"


def parse_theme(filepath: str) -> dict:
    """Parse a theme shell script and extract colors."""
    content = Path(filepath).read_text()

    theme = {
        'name': 'Unknown Theme',
        'slug': Path(filepath).stem,
        'background': (30, 30, 30),
        'foreground': (220, 220, 220),
        'palette': []
    }

    # Extract theme name
    name_match = re.search(r"PROFILE_NAME=[\"']([^\"']+)[\"']", content)
    if name_match:
        theme['name'] = name_match.group(1)

    # Extract background color
    bg_match = re.search(r"background-color='(rgb\([^)]+\))'", content)
    if bg_match:
        theme['background'] = parse_rgb(bg_match.group(1))

    # Extract foreground color
    fg_match = re.search(r"foreground-color='(rgb\([^)]+\))'", content)
    if fg_match:
        theme['foreground'] = parse_rgb(fg_match.group(1))

    # Extract palette colors
    palette_match = re.search(r"palette=\[([^\]]+)\]", content)
    if palette_match:
        palette_str = palette_match.group(1)
        colors = re.findall(r"'(rgb\([^)]+\))'", palette_str)
        theme['palette'] = [parse_rgb(c) for c in colors]

    # Ensure we have 16 colors
    while len(theme['palette']) < 16:
        theme['palette'].append((128, 128, 128))

    return theme


def generate_svg(theme: dict) -> str:
    """Generate an SVG preview for the theme."""
    bg = rgb_to_hex(theme['background'])
    fg = rgb_to_hex(theme['foreground'])
    palette = [rgb_to_hex(c) for c in theme['palette']]
    
    # Color names for reference
    color_names = ['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white']
    
    width = 700
    height = 420
    padding = 20
    
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">
  <defs>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="2" dy="2" stdDeviation="3" flood-opacity="0.3"/>
    </filter>
  </defs>
  
  <!-- Terminal window -->
  <rect x="0" y="0" width="{width}" height="{height}" rx="10" fill="{bg}" filter="url(#shadow)"/>
  
  <!-- Title bar -->
  <rect x="0" y="0" width="{width}" height="36" rx="10" fill="{bg}"/>
  <rect x="0" y="26" width="{width}" height="10" fill="{bg}"/>
  
  <!-- Window controls -->
  <circle cx="20" cy="18" r="6" fill="#ff5f56"/>
  <circle cx="40" cy="18" r="6" fill="#ffbd2e"/>
  <circle cx="60" cy="18" r="6" fill="#27ca40"/>
  
  <!-- Title -->
  <text x="{width // 2}" y="22" font-family="monospace" font-size="12" fill="{fg}" text-anchor="middle" opacity="0.7">{theme['name']}</text>
  
  <!-- Separator line -->
  <line x1="0" y1="36" x2="{width}" y2="36" stroke="{fg}" stroke-opacity="0.2"/>
  
  <!-- Content area -->
  <g transform="translate({padding}, 50)">
    <!-- Sample prompt and commands -->
    <text font-family="monospace" font-size="14" fill="{fg}">
      <tspan x="0" y="20" fill="{palette[2]}">❯</tspan>
      <tspan fill="{fg}"> fastfetch</tspan>
    </text>
    
    <!-- System info block -->
    <text font-family="monospace" font-size="13">
      <tspan x="0" y="50" fill="{palette[6]}">OS</tspan>
      <tspan fill="{fg}" opacity="0.5"> -&gt; </tspan>
      <tspan fill="{fg}">Ubuntu 24.04 LTS x86_64</tspan>
      
      <tspan x="0" y="72" fill="{palette[3]}">⚙</tspan>
      <tspan fill="{fg}" opacity="0.5"> -&gt; </tspan>
      <tspan fill="{fg}">Linux 6.17.0-14-generic</tspan>
      
      <tspan x="0" y="94" fill="{palette[5]}">📦</tspan>
      <tspan fill="{fg}" opacity="0.5"> -&gt; </tspan>
      <tspan fill="{fg}">1931 (dpkg), 11 (snap)</tspan>
      
      <tspan x="0" y="116" fill="{palette[1]}">🐚</tspan>
      <tspan fill="{fg}" opacity="0.5"> -&gt; </tspan>
      <tspan fill="{fg}">zsh 5.9</tspan>
      
      <tspan x="0" y="138" fill="{palette[4]}">🖥</tspan>
      <tspan fill="{fg}" opacity="0.5"> -&gt; </tspan>
      <tspan fill="{fg}">GNOME Terminal 3.52.0</tspan>
      
      <tspan x="0" y="160" fill="{palette[2]}">🎨</tspan>
      <tspan fill="{fg}" opacity="0.5"> -&gt; </tspan>
      <tspan fill="{fg}">{theme['name']}</tspan>
    </text>
    
    <!-- Sample code block -->
    <text font-family="monospace" font-size="13">
      <tspan x="0" y="200" fill="{palette[8]}"># Sample syntax highlighting</tspan>
      <tspan x="0" y="222" fill="{palette[4]}">function</tspan>
      <tspan fill="{palette[3]}"> greet</tspan>
      <tspan fill="{fg}">() {'{'}</tspan>
      <tspan x="0" y="244" fill="{fg}">    </tspan>
      <tspan fill="{palette[4]}">echo</tspan>
      <tspan fill="{fg}"> </tspan>
      <tspan fill="{palette[2]}">"Hello, </tspan>
      <tspan fill="{palette[6]}">$USER</tspan>
      <tspan fill="{palette[2]}">!"</tspan>
      <tspan x="0" y="266" fill="{fg}">{'}'}</tspan>
    </text>
    
    <!-- Color palette circles - Normal colors -->
    <g transform="translate(0, 290)">
      <text x="0" y="-5" font-family="monospace" font-size="11" fill="{fg}" opacity="0.6">Normal</text>'''
    
    # Normal colors (0-7)
    for i in range(8):
        x = i * 36
        svg += f'''
      <circle cx="{x + 12}" cy="18" r="12" fill="{palette[i]}" stroke="{fg}" stroke-opacity="0.2"/>'''
    
    svg += f'''
    </g>
    
    <!-- Color palette circles - Bright colors -->
    <g transform="translate(320, 290)">
      <text x="0" y="-5" font-family="monospace" font-size="11" fill="{fg}" opacity="0.6">Bright</text>'''
    
    # Bright colors (8-15)
    for i in range(8):
        x = i * 36
        svg += f'''
      <circle cx="{x + 12}" cy="18" r="12" fill="{palette[i + 8]}" stroke="{fg}" stroke-opacity="0.2"/>'''
    
    svg += f'''
    </g>
  </g>
</svg>'''
    
    return svg


def update_readme(themes: list[dict], preview_dir: Path, readme_path: Path):
    """Update README.md with theme previews section."""
    content = readme_path.read_text()

    # Sort themes alphabetically by name
    sorted_themes = sorted(themes, key=lambda t: t['name'].lower())

    # Generate the preview section
    preview_section = "\n## Theme Previews\n\n"

    for theme in sorted_themes:
        preview_file = preview_dir / f"{theme['slug']}.svg"
        if preview_file.exists():
            # Use relative path from README location
            relative_path = f"previews/{theme['slug']}.svg"
            preview_section += f"### {theme['name']}\n"
            preview_section += f'<img src="{relative_path}" alt="{theme["name"]}" width="850">\n\n'

    # Check if preview section already exists
    preview_marker = "## Theme Previews"
    if preview_marker in content:
        # Find the start and end of the existing preview section
        start_idx = content.index(preview_marker)
        # Find the next ## heading or end of file
        remaining = content[start_idx + len(preview_marker):]
        next_section_match = re.search(r'\n## [^#]', remaining)
        if next_section_match:
            end_idx = start_idx + len(preview_marker) + next_section_match.start()
            content = content[:start_idx] + preview_section.rstrip() + "\n" + content[end_idx:]
        else:
            content = content[:start_idx] + preview_section.rstrip() + "\n"
    else:
        # Add before "## Usage" section if it exists, otherwise at the end
        usage_marker = "## Usage"
        if usage_marker in content:
            idx = content.index(usage_marker)
            content = content[:idx] + preview_section + content[idx:]
        else:
            content += preview_section

    readme_path.write_text(content)
    print(f"Updated {readme_path}")


def get_all_themes(themes_dir: Path) -> list[Path]:
    """Get all theme files, excluding utility scripts."""
    excluded = {'cleanup_invalid_profiles.sh'}
    return sorted([
        f for f in themes_dir.glob('*.sh')
        if f.name not in excluded
    ])


def main():
    parser = argparse.ArgumentParser(description='Generate theme previews')
    parser.add_argument('files', nargs='*', help='Theme files to process')
    parser.add_argument('--all', action='store_true', help='Process all themes')
    parser.add_argument('--update-readme', action='store_true', help='Update README with previews')
    parser.add_argument('--output-dir', default='previews', help='Output directory for SVGs')
    parser.add_argument('--themes-dir', default='themes', help='Themes directory')
    parser.add_argument('--readme', default='README.md', help='README file path')

    args = parser.parse_args()

    # Determine base directory (repo root)
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent.parent  # .github/scripts -> .github -> repo root

    output_dir = repo_root / args.output_dir
    themes_dir = repo_root / args.themes_dir
    readme_path = repo_root / args.readme

    output_dir.mkdir(exist_ok=True)

    # Determine which files to process
    if args.all:
        theme_files = get_all_themes(themes_dir)
    elif args.files:
        theme_files = [Path(f) for f in args.files if f.strip()]
    else:
        print("No theme files specified. Use --all or provide file paths.")
        sys.exit(1)

    # Generate previews
    generated_themes = []
    for filepath in theme_files:
        if not filepath.exists():
            print(f"Warning: {filepath} not found, skipping")
            continue

        print(f"Generating preview for {filepath.name}...")

        try:
            theme = parse_theme(str(filepath))
            svg = generate_svg(theme)

            output_file = output_dir / f"{filepath.stem}.svg"
            output_file.write_text(svg)
            print(f"  Created: {output_file}")

            generated_themes.append(theme)
        except Exception as e:
            print(f"  Error: {e}")

    # Update README if requested
    if args.update_readme and generated_themes:
        # If updating README, we need all themes for proper ordering
        if not args.all:
            # Load all existing themes for complete list
            all_theme_files = get_all_themes(themes_dir)
            generated_themes = []
            for filepath in all_theme_files:
                try:
                    theme = parse_theme(str(filepath))
                    generated_themes.append(theme)
                except Exception:
                    pass

        update_readme(generated_themes, output_dir, readme_path)

    print(f"\nGenerated {len(generated_themes)} preview(s)")


if __name__ == "__main__":
    main()
