

# Search strategy

1  Find packages by name
1a Optionally (preferably) when dealing with large result sets, limit by popularity
   (npm-research)


1  `npm ls` will parse a dependency tree, `npm la` does it in depth


# Selection criteria




# Source inspection




# Lazy loading




# Modularization

* easy-app

For big applications definition of everything in a single global container is a
bad choice. In fact we want to compose such application from small loosely
coupled pieces with very few things in common. No problem:

    var subapp = App() // subapp is a normal app

    // define tasks as usual
    // Note that we are using short names like `req`.
    // Not http_request, approval_request, etc
    subapp.def('req', function(bar, baz) {})

    // Specify missing tasks.
    subapp.importing(
      'bar',
        'baz'
        )



