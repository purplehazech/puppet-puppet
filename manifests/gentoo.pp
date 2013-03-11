class puppet::gentoo {
  
  file {'/etc/portage/package.use/10_puppet__net-tools':
    content => 'sys-apps/net-tools old-output',
    mode    => '0644'
  }
  
  file { '/etc/portage/package.use/10_puppet': 
    content => 'app-admin/puppet vim-syntax augeas diff ldap',
    mode    => '0644'
  }
  
  file { '/etc/portage/package.use/10_puppet__openldap':
    content => 'net-nds/openldap minimal',
    mode    => '0644'
  }
  
  file { '/etc/portage/package.keywords/10_puppet__puppet-infra-project':
    content => 'app-admin/puppet-infra-project ~amd64',
    mode    => '0644'
  }
  
  file { '/etc/portage/package.use/10_puppet__activerecord':
    content => 'dev-ruby/activerecord mysql',
    mode    => '0644'
  }
  
  file {'/etc/portage/package.keywords/10_puppet':
    content => '=app-admin/puppet-3.1.0 ~amd64',
    mode    => '0644'
  }
  file {'/etc/portage/package.keywords/10_puppet__puppet-syntax':
    content => '=app-vim/puppet-syntax-3.0.1 ~amd64',
    mode    => '0644'
  }
  file {'/etc/portage/package.keywords/10_puppet__hiera':
    content => '=dev-ruby/hiera-1.1.2-r1 ~amd64',
    mode    => '0644'
  } 
}