awk '{
    gsub(/\./, ""); 
    for (i = 1; i <= NF; i++) {
        w = tolower($i); 
        count[w]++; 
        words[w] = w
    }
} 
END {
    qty = asort(words); 
    for (w = 1; w <= qty; w++)
        print words[w] "|" count[words[w]]
}' INPUT/ironsort222.csv
