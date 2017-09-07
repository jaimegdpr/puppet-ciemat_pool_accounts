class pool_accounts::users {

    require pool_accounts::files
    
    #Get VO list from Hiera and transform it to a string
    $supported_vos_array = lookup('glexecwn::supported_vos', Array[String], 'unique', undef)
    $supported_vos_string = join($supported_vos_array, ' ')
    $supported_vos_string_commas = join($supported_vos_array, ',')

    
    if defined(Service['ypbind']){

        #Script for creating users only runs when there are missing accounts
        exec {"pool_accounts":
            command => "/root/pool_accounts/create_users.sh users.conf ${supported_vos_string_commas}",
            cwd => '/root/pool_accounts',
            onlyif => "/root/pool_accounts/check_missing_users.sh users.conf ${supported_vos_string}",
            logoutput => true,
            timeout => 0,
            #TODO: Check if ypbind service is declared
            before => Service['ypbind'],}
    } else {
        exec {"pool_accounts":
            command => "/root/pool_accounts/create_users.sh users.conf ${supported_vos_string_commas}",
            cwd => '/root/pool_accounts',
            onlyif => "/root/pool_accounts/check_missing_users.sh users.conf ${supported_vos_string}",
            logoutput => true,
            timeout => 0,} 
    }
}
