# DNS Blacklist Updater

This project provides a Ruby script to update a DNS blacklist by consolidating a base list with an exception list.

## Files

- `update_host_list_script.rb`: The main script to run the update process.
- `lib/core.rb`: Contains the core logic for updating the DNS blacklist and managing exceptions.
- `dns-black-list.txt`: (Presumed) The base DNS blacklist.
- `dns-exception-list.txt`: (Presumed) A list of exceptions to the DNS blacklist.
- `consolidated-list/consolidated_list.txt`: The output file containing the updated and consolidated DNS blacklist.

PS: You can use multiple files in each folder for better control of what is being blocked or allowed.

## How to Use

To update the DNS blacklist, run the `update_host_list_script.rb`:

```bash
ruby update_host_list_script.rb
```

This script will:
1. Update the DNS blacklist using the base list from the web and the files inside of "dns-files" folder (eg `dns-black-list.txt`).
2. Apply the exception list from the files inside the "dns-exception-list" folder (eg `dns-exception-list.txt`) to remove hosts from blacklist.
3. Save the final consolidated list to `consolidated-list/consolidated_list.txt`.

## Customization

To customize the base list or exception list, modify `dns-black-list.txt` and `dns-exception-list.txt` respectively.
