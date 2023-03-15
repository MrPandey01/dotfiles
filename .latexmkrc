 # Custom dependency and function for nomencl package 
 add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
 sub makenlo2nls {
 system( "makeindex -s nomencl.ist -t $_[0].nlg -o $_[0].nls $_[0].nlo" );
 }

push @generated_exts, "glo";
push @generated_exts, "gls";
push @generated_exts, "glg";

add_cus_dep('glo', 'gls', 0, 'glo2gls');
sub glo2gls {
  system("makeindex $_[0].glo -s $_[0].ist -o $_[0].gls -t $_[0].glg" );
}
