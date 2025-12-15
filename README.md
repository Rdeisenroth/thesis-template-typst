<div align="center">
  <a href="https://github.com/Rdeisenroth/thesis-template-typst/actions/workflows/build.yml">
    <img src="https://github.com/Rdeisenroth/thesis-template-typst/actions/workflows/build.yml/badge.svg" alt="build" />
  </a>
  <a href="https://github.com/Rdeisenroth/thesis-template-typst/actions/workflows/check.yml">
    <img src="https://github.com/Rdeisenroth/thesis-template-typst/actions/workflows/check.yml/badge.svg" alt="check" />
  </a>
  <a href="https://typst.app/">
    <img src="https://img.shields.io/badge/Typst-Based-blue" alt="Typst Badge" />
  </a>
</div>



<div align="center" style="margin: 2em 0;">
  <style>
    .wip-warning-box {
      border: 3px solid #e67e22;
      background: #fffbe6;
      border-radius: 10px;
      box-shadow: 0 2px 8px #e67e2240;
      color: #333;
    }
    @media (prefers-color-scheme: dark) {
      .wip-warning-box {
        border-color: #ffb84d;
        background: #2d2200;
        color: #ffe6b3;
        box-shadow: 0 2px 8px #ffb84d40;
      }
      .wip-warning-title {
        color: #ffb84d;
      }
    }
    .wip-warning-title {
      font-size: 2em;
      font-weight: bold;
      color: #e67e22;
    }
    .wip-warning-text {
      font-size: 1.1em;
      color: inherit;
    }
  </style>
  <table width="100%" class="wip-warning-box">
    <tr>
      <td style="padding: 1.5em; text-align: center;">
        <span class="wip-warning-title">🚧 WIP: This template is still under active construction 🚧</span>
        <br><br>
        <span class="wip-warning-text">
          This template does not have the same level of polish as <a href="https://github.com/Rdeisenroth/latex-repo-templates" target="_blank">my LaTeX templates</a> (yet). Should you decide to use it for your thesis, I heavily recommend you remove packages you don't use and read through the preamble at least.<br><br>
          <b>Also make sure to actively communicate with your supervisor, on whether the use of this template or Typst in general is allowed.</b><br><br>
          <b>I will not take any responsibility if you have to redo it in LaTeX later.</b>
        </span>
      </td>
    </tr>
  </table>
</div>


# thesis-template-typst

<div align="center" style="margin-bottom: 1em;">
  <b>Looking for my LaTeX templates instead?</b><br>
  👉 <a href="https://github.com/Rdeisenroth/latex-repo-templates">https://github.com/Rdeisenroth/latex-repo-templates</a>
</div>

My thesis-template-typsts for TU Darmstadt, created with [Typst](https://typst.app/).

You can download the latest version of the materials here:
<p align="center">
  <b>Latest version of the Thesis</b><br>
  <a href="https://nextcloud.domain.tld/public.php/dav/files/some_file_id" style="text-decoration:none;">
    <img src="https://img.shields.io/badge/Download%20Thesis-Light%20Mode-blue?style=for-the-badge" alt="Download Thesis Light Mode" />
  </a>
  <a href="https://nextcloud.domain.tld/public.php/dav/files/some_file_id" style="text-decoration:none; margin-left: 10px;">
    <img src="https://img.shields.io/badge/Download%20Thesis-Dark%20Mode-black?style=for-the-badge" alt="Download Thesis Dark Mode" />
  </a>
  <br><br>
  <b>Latest Version of the Slides</b><br>
  <a href="https://nextcloud.domain.tld/public.php/dav/files/some_file_id/" style="text-decoration:none;">
    <img src="https://img.shields.io/badge/Download%20Slides-Light%20Mode-blue?style=for-the-badge" alt="Download Slides Light Mode" />
  </a>
  <a href="https://nextcloud.domain.tld/public.php/dav/files/some_file_id/" style="text-decoration:none; margin-left: 10px;">
    <img src="https://img.shields.io/badge/Download%20Slides-Dark%20Mode-black?style=for-the-badge" alt="Download Slides Dark Mode" />
  </a>
</p>

## Authoren
- [Ruben Deisenroth](https://github.com/Rdeisenroth)


## Wie kann ich Helfen?
Wenn dir ein Fehler aufgefallen ist, du die Vorlage erweitern willst oder einfach nur Anregungen hast kannst du entwerder einen PR oder Issue eröffnen, oder mir auf Discord eine DM senden (`@rubosplay`).

### Git-Workflow für Collaborators
Für alle größeren Änderungen sollte ein neuer Feature-Branch erstellt werden, der dann durch einen PR in den `main`-Branch gemerged wird. Dabei werden die Commits des Feature-Branches in einem Squash-Merge zusammengefasst, sodass die Historie des `main`-Branches übersichtlich bleibt. Feature branches werden nach dem Mergen automatisch gelöscht.
