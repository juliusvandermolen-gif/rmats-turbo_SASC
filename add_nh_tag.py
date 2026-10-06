import sys
import pysam

in_path, out_path = sys.argv[1], sys.argv[2]

bam_in = pysam.AlignmentFile(in_path, "rb")
bam_out = pysam.AlignmentFile(out_path, "wb", template=bam_in)

for read in bam_in:
    if read.has_tag('XT') and read.get_tag('XT') == 'U':
        nh = 1
    elif read.has_tag('XA'):
        nh = read.get_tag('XA').count(';') + 1
    else:
        nh = 1  # geen info beschikbaar -> aanname uniek
    read.set_tag('NH', nh, value_type='i')
    bam_out.write(read)

bam_in.close()
bam_out.close()
print("klaar: %s" % out_path)