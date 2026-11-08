# PDF-XChange Editor — session-only portable launcher

Downloads **official PDF-XChange Editor v11.1.1.0, x64, No OCR**, verifies the vendor-published SHA-256 checksum, extracts it to a uniquely named temporary folder, runs the editor, then deletes the temporary app folder after it exits.

- No installation, administrator privileges, Windows startup, default PDF association, or permanent system settings requested.
- The portable editor normally starts with its built-in **English (US)** UI. If not: **File > Preferences > Languages > English (US), Built-In**.
- **Keep the PowerShell window open.** Closing the editor normally triggers cleanup.
- Save your edited PDFs to a separate folder, not inside the temporary app directory. The launcher never intentionally deletes external documents.
- This is an official portable **Editor**, not the separate PDF-Tools product or PDF-XChange printer driver.

## Run on Windows PowerShell

Replace `USERNAME` if your repo is under another account:

```powershell
irm https://raw.githubusercontent.com/Seidkhan-Yusupov/pdfxchange-portable/main/launch.ps1 | iex
```

**Security:** This convenience command directly executes changing remote code. Only use your own reviewed repository. A safer approach is to download `launch.ps1`, inspect it, then execute that local file according to the university computer's policies.

## Cleanup and limitations

1. Save PDFs to your own approved location and close the editor.
2. Wait for PowerShell to say `Portable application files removed.`
3. Sign out of the shared computer and remove personal documents/downloads you created where appropriate.

If the process is forcibly terminated, the machine reboots, or some portable file remains locked, cleanup may not complete. The script prints the exact temporary folder if deletion fails. It does **not** erase Windows recent-file history, print queues, or PDF documents elsewhere, and it is not a privacy guarantee.

If university policy blocks running downloaded executables or PowerShell, do not bypass it.

Vendor: https://www.pdf-xchange.com/product/pdf-xchange-editor
