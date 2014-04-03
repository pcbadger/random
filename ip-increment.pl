use Socket;

my $netmask = 0xFFFFFF00; # 255.255.255.0

my $start_address = unpack 'N', inet_aton( '10.11.1.14' );
my $finish_address = unpack 'N', inet_aton( '12.13.2.3' );

for ( my $address = $start_address; $address <= $finish_address; ++$address ) {
next if ( $address & $netmask ) == $address or ( $address & ~$netmask ) == ~$netmask;
print inet_ntoa( pack 'N', $address );
}

