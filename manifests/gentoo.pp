class puppet::gentoo (
  $puppet_mode = 2
) {
  
  file {'/etc/portage/package.use/10_puppet__net-tools':
    content => 'sys-apps/net-tools old-output'
  }
  
  file { '/etc/portage/package.use/10_puppet': 
    content => 'app-admin/puppet vim-syntax augeas diff ldap'
  }
  
  case $puppet_mode {
    3 : {
      file {'/etc/portage/package.keywords/10_puppet':
        content => '=app-admin/puppet-3.1.0 ~amd64'
      }
      file {'/etc/portage/package.keywords/10_puppet__puppet-syntax':
        content => '=app-vim/puppet-syntax-3.0.1 ~amd64'
      }
      file {'/etc/portage/package.keywords/10_puppet__hiera':
        content => '=dev-ruby/hiera-1.1.2-r1 ~amd64'
      }
    }
  }
  
}