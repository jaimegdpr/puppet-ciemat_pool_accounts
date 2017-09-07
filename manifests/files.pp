class pool_accounts::files {

    file {'/root/pool_accounts':
        ensure => directory,
        owner => 'root',
        group => 'root',
        mode => '0700',
    }

    file {'/root/pool_accounts/users.conf':
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => '0600',
        source => 'puppet:///grid_files/pool_accounts/users.conf',
        require => File['/root/pool_accounts'],
    }

    file {'/root/pool_accounts/check_missing_users.sh':
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => '0700',
        source => 'puppet:///grid_files/pool_accounts/check_missing_users.sh',
        require => File['/root/pool_accounts'],
    }

    file {'/root/pool_accounts/create_users.sh':
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => '0700',
        source => 'puppet:///grid_files/pool_accounts/create_users.sh',
        require => File['/root/pool_accounts'],
    }
}
