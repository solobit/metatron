

# guidance

#
#   // testing keyboard
#   var keyText = new PointText( view.center );
#       keyText.characterStyle.fontSize = 64;
#       keyText.justification = 'center';
#       keyText.fillColor = '#999';
#   function onKeyDown( event ) {
#
#       console.log( 'onKeyDown' );
#       console.log( event );
#
#       keyText.content = event.key;
#   }
#   

    # animations
    onFrame = (event) ->
        return  if not aCurrent and not aQueue.length
        aCurrent = aQueue.shift()  unless aCurrent
        aCurrent = aCurrent()

    # animaters
    AnimateOpacity = (shape, opacity) ->
        remaining = opacity
        increment = 0.05
        animater = ->
        
            # calculate this move (either increment or whatevers left)
            thisMove = (if remaining - increment < 0 then remaining else increment)
            remaining -= thisMove
            
            # do the thing
            shape.opacity += thisMove
            
            # return function if not done
        unless remaining
          
            # cleanup reference
            animater = null
                
            # kill cycle
            false

        animater

    AnimatePositionY = (shape, distance) ->
        remaining = distance
        increment = 1
        shapeShown = false
        animater = ->
        
            # first time? reveal
            unless shapeShown
                shape.opacity = 1
                shapeShown = true
        
            # calculate this move (either increment or whatevers left)
            thisMove = (if remaining - increment < 0 then remaining else increment)
            remaining -= thisMove
        
            # do the thing
            shape.position.y += thisMove
        
            # return function if not done
            unless remaining
          
                # cleanup reference
                animater = null
          
                # kill cycle
                false

        animater

    AnimateRotation = (shape, angle, point) ->

        point = point or shape.position
        remaining = angle
        increment = 1
        shapeShown = false
        animater = ->
        
            # first time? reveal
            unless shapeShown
                shape.opacity = 1
                shapeShown = true
        
            # calculate this move (either increment or whatevers left)
            thisMove = (if remaining - increment < 0 then remaining else increment)
            remaining -= thisMove
        
            # do the thing
            shape.rotate thisMove, point
            
            # return function if not done
            unless remaining
          
                # cleanup reference
                animater = null

                # kill cycle
                false

        animater

    AnimateStrokeColor = (shape, color) ->
        animater = ->
        
            # do the thing
            shape.strokeColor = color
            
            # cleanup reference
            animater = null
            
            # kill cycle
            false

        animater

    # factory
    Metatron = (origin, radius) ->
        construct = ->
        
            # all circles
            circles = []
            
            # center circle
            original = new Path.Circle(origin, radius)
            original.strokeColor = "#3CF"
            original.strokeWidth = 2
            original.opacity = 0
            original.name = "original"
            circles.push original
            aQueue.push new AnimateOpacity(original, 1)
            
            # branches
            i = 0
            l = 6

            while i < l
                if i is 0
                  
                    # lower circles from original
                    copy1 = original.clone()
                    copy1.opacity = 0
                    copy1.name = "copy1:" + i
                    circles.push copy1
                    aQueue.push new AnimatePositionY(copy1, radius * 2)
                    copy2 = original.clone()
                    copy2.position.y += radius * 2
                    copy2.opacity = 0
                    copy2.name = "copy2:" + i
                    circles.push copy2
                    aQueue.push new AnimatePositionY(copy2, radius * 2)
                
                else

                    # rotate branch from previous
                    copy1 = original.clone()
                    copy1.opacity = 1
                    copy1.name = "copy1:" + i
                    copy1.position.y += radius * 2
                    circles.push copy1
                    copy2 = original.clone()
                    copy2.opacity = 1
                    copy2.name = "copy2:" + i
                    copy2.position.y += radius * 2 * 2
                    circles.push copy2
                    branch = new Group([copy1, copy2])
                    branch.opacity = 0
                    branch.rotate 60 * i - 60, origin
                    aQueue.push new AnimateRotation(branch, 60, origin)
                i++
        
            # paths
            aQueue.push ->
                paths = []
                alreadyConnected = {}
          
                # connect every circle to every other circle 1 time
                i = 0
                l = circles.length

                while i < l
                    thisCircle = circles[i]
                    aQueue.push new AnimateStrokeColor(thisCircle, "#000")
                    ii = 0
                    ll = l

                while ii < ll
                    continue  if i is ii
                    thatCircle = circles[ii]
                    if alreadyConnected[thatCircle.name + thisCircle.name]
                        continue
                    else
                        alreadyConnected[thisCircle.name + thatCircle.name] = true
                    path = new Path(thisCircle.position, thatCircle.position)
                    path.strokeCap = "round"
                    path.strokeColor = "#000"
                    path.strokeWidth = 2
                    path.opacity = 0
                    paths.push path
                    aQueue.push new AnimateOpacity(path, 0.7)
                    ii++
                aQueue.push new AnimateStrokeColor(thisCircle, "#3CF")
                i++

        construct()
        {}

    # click
    onMouseUp = (event) ->
        if isBuilt
            return
        else
            isBuilt = true
        hintText.remove()
        new Metatron(view.center, 50)

     
### Backdrop

    background = new Path.Rectangle(view.bounds)
    background.fillColor = "white"
    hintText = new PointText(view.center)
    hintText.justification = "center"
    hintText.fillColor = "#999"
    hintText.content = "Click"
    hintText.position.y += 3
    aQueue = []
    aCurrent = undefined
    isBuilt = false