#!/bin/tcsh

rm -r CRF_corrmats_.5mm
mkdir CRF_corrmats_.5mm
cd CRF_corrmats_.5mm

foreach subj ( 109C 119C 121C 122C 125C 128C 133C 145C 152C 151C 154C 165C 166C 182C 168C 170C 173C 178C 179C 183C 185C 186C 195C 197C 101C 418C_V2 415C 407C 402C 176C 020A 038A 045A 056A 082A 092A 095A 114A 123A 131A 138A 140A 141A 144A 147A 148A 153A 155A 157A 159A 160A 167A 174A 175A 181A 191A 192A 194A 196A 198A_V2 199A 224A 225A 226A 404A 405A 406A_V2 420A 413A 414A 408A 410A )

    echo
    echo "Processing subject " ${subj} 
    echo 

	cat ../timeseries_.5mm_ABIDE_CRF_invert/${subj}/* > __tmp_${subj}_ts_all.1D
	sed '' __tmp_${subj}_ts_all.1D > __tmp2.1D; mv __tmp2.1D __tmp_${subj}_ts_all.1D
	1ddot -dem -okzero -terse "__tmp_${subj}_ts_all.1D'" > ${subj}_corrmat.1D

	rm __tmp_*
	
end

/afrooz@cinci:~/Rcodes/ABIDE/RF/dim.red/2per
