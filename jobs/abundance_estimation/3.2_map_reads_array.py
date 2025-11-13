import os
import subprocess

# Set the data directories (either mounted or synced locally)
data_dir = os.path.expanduser("~/euler_scratch/updog/scripts")  # <-- SSHFS mount
# data_dir = os.path.expanduser("~/projects/updog")             # <-- if rsynced

part_dir = os.path.join(data_dir, "partitioned_seqs")

# Example: loop through partitioned QZA files
for i in range(1, 11):
    reads_qza = os.path.join(part_dir, f"seqs_{i}.qza")
    out_dir = os.path.join(data_dir, "map_reads_local", f"reads_to_derep_mags_{i}.qza")

    # Local command using the QIIME environment
    cmd = [
        "mosh", "assembly", "map-reads",
        "--i-index", os.path.join(data_dir, "mags_derep_all_domains_index.qza"),
        "--i-reads", reads_qza,
        "--p-threads", "8",
        "--p-seed", "100",
        "--o-alignment-maps", out_dir
    ]

    print("Running:", " ".join(cmd))
    subprocess.run(cmd, check=True)