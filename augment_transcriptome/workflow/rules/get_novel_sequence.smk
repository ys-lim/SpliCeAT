rule get_novel_sequence:
    input:
        config["BASE_PATH"]+"results/merged_assembly/merged_stringtie_assembly_novel_exon_filtered.gtf"
    output:
        config["BASE_PATH"]+"results/augmented_transcriptome/merged_stringtie_assembly_novel_exon_filtered.fa"
    params:
        gffread=config["gff_read_path"],
        genome=config["genome_fasta"]
    threads:
        4
    shell:
        "{params.gffread}" -w {output} -g {params.genome} {input}"
