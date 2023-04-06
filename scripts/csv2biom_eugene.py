# USAGE: csv2biom.py OTU_TABLE.csv OTU_TABLE.biom

import sys

import pandas as pd
import biom
from biom.util import biom_open, HAVE_H5PY
from biom.exception import BiomException


class EmptyBIOMTableError(BiomException):
    """Exception for when an empty BIOM table is encountered."""
    pass


def write_biom_table(biom_table, biom_table_fp, compress=True,
                     write_hdf5=HAVE_H5PY, table_type='OTU table'):
    """Writes a BIOM table to the specified filepath

    Parameters
    ----------
    biom_table : biom.Table
        The table object to write out
    biom_table_fp : str
        The path to the output file
    compress : bool, optional
        Defaults to ``True``. If True, built-in compression on the output HDF5
        file will be enabled. This option is only relevant if ``write_hdf5`` is
        ``True``.
    write_hdf5 : bool, optional
        Defaults to ``True`` if H5PY is installed and to ``False`` if H5PY is
        not installed. If ``True`` the output biom table will be written as an
        HDF5 binary file, otherwise it will be a JSON string.
    table_type : str, optional
        The Table.type value to set for the table before it is written. Note
        that this is a controlled vocabulary documented on biom-format.org.

    Raises
    ------
    EmptyBIOMTableError
        If ``biom_table.is_empty() == True``. 
    """
    if biom_table.is_empty():
        raise EmptyBIOMTableError(
            "Attempting to write an empty BIOM table to disk. "
            "QIIME doesn't support writing empty BIOM output files.")

    generated_by = "qiime"
    biom_table.type = table_type

    if write_hdf5:
        with biom_open(biom_table_fp, 'w') as biom_file:
            biom_table.to_hdf5(biom_file, generated_by, compress)
    else:
        with open(biom_table_fp, 'w') as biom_file:
            biom_table.to_json(generated_by, biom_file)


def main(inp, out):
    sample_ids = ["v219","v220","v223","v224","v225","v227","v229"]
    meta_columns = ['domain', 'phylum', 'class', 'order', 'family', 'genus']
    index_column = 'OTU'

    df = pd.read_csv(inp)

    data = df[sample_ids].fillna(0).values
    observ_ids = df[index_column].values
    print("observ_ids: ", observ_ids)

    sample_metadata = []
    for sample_name in sample_ids:
        meta = {
            "Sample": sample_name,
        }
        sample_metadata.append(meta)

    observ_metadata = []
    for _, row in df.iterrows():
        taxa = []
        for mc in meta_columns:
            if isinstance(row[mc], str):
                taxa.append(row[mc])
            else:
                break
        meta = {"taxonomy": taxa}
        observ_metadata.append(meta)

    otu_table = biom.Table(
        data, observ_ids, sample_ids, 
        observ_metadata, sample_metadata, 
        table_id='Valerik Table'
    )
    write_biom_table(otu_table, out)


if __name__ == "__main__":
    main("data/eugene/comp_full.csv", "data/eugene/otu_table.biom")
