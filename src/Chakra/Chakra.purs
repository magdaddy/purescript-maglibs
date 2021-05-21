module MagLibs.Chakra where

import React.Basic.Hooks (JSX, ReactComponent, element)


box :: forall r. Record r -> JSX
box props = element _Box props

button :: forall r. Record r -> JSX
button props = element _Button props

chakraProvider :: forall r. Record r -> JSX
chakraProvider props = element _ChakraProvider props

flex :: forall r. Record r -> JSX
flex props = element _Flex props

input :: forall r. Record r -> JSX
input props = element _Input props

hStack :: forall r. Record r -> JSX
hStack props = element _HStack props

link :: forall r. Record r -> JSX
link props = element _Link props

modal :: forall r. Record r -> JSX
modal props = element _Modal props
modalBody :: forall r. Record r -> JSX
modalBody props = element _ModalBody props
modalCloseButton :: forall r. Record r -> JSX
modalCloseButton props = element _ModalCloseButton props
modalContent :: forall r. Record r -> JSX
modalContent props = element _ModalContent props
modalFooter :: forall r. Record r -> JSX
modalFooter props = element _ModalFooter props
modalHeader :: forall r. Record r -> JSX
modalHeader props = element _ModalHeader props
modalOverlay :: forall r. Record r -> JSX
modalOverlay props = element _ModalOverlay props

spacer :: JSX
spacer = element _Spacer { }

text :: forall r. Record r -> JSX
text props = element _Text props

vStack :: forall r. Record r -> JSX
vStack props = element _VStack props


box_ :: Array JSX -> JSX
box_ children = box { children }

chakraProvider_ :: Array JSX -> JSX
chakraProvider_ children = chakraProvider { children }

flex_ :: Array JSX -> JSX
flex_ children = flex { children }

hStack_ :: Array JSX -> JSX
hStack_ children = hStack { children }

modal_ :: Array JSX -> JSX
modal_ children = modal { children }
modalBody_ :: Array JSX -> JSX
modalBody_ children = modalBody { children }
modalCloseButton_ :: Array JSX -> JSX
modalCloseButton_ children = modalCloseButton { children }
modalContent_ :: Array JSX -> JSX
modalContent_ children = modalContent { children }
modalFooter_ :: Array JSX -> JSX
modalFooter_ children = modalFooter { children }
modalHeader_ :: Array JSX -> JSX
modalHeader_ children = modalHeader { children }
modalOverlay_ :: Array JSX -> JSX
modalOverlay_ children = modalOverlay { children }

vStack_ :: Array JSX -> JSX
vStack_ children = vStack { children }

foreign import _Box                :: forall r. ReactComponent (Record r)
foreign import _Button             :: forall r. ReactComponent (Record r)
foreign import _ChakraProvider     :: forall r. ReactComponent (Record r)
foreign import _Flex               :: forall r. ReactComponent (Record r)
foreign import _Input              :: forall r. ReactComponent (Record r)
foreign import _HStack             :: forall r. ReactComponent (Record r)
foreign import _Link               :: forall r. ReactComponent (Record r)
foreign import _Modal              :: forall r. ReactComponent (Record r)
foreign import _ModalBody          :: forall r. ReactComponent (Record r)
foreign import _ModalCloseButton   :: forall r. ReactComponent (Record r)
foreign import _ModalContent       :: forall r. ReactComponent (Record r)
foreign import _ModalFooter        :: forall r. ReactComponent (Record r)
foreign import _ModalHeader        :: forall r. ReactComponent (Record r)
foreign import _ModalOverlay       :: forall r. ReactComponent (Record r)
foreign import _Spacer             :: forall r. ReactComponent (Record r)
foreign import _Text               :: forall r. ReactComponent (Record r)
foreign import _VStack             :: forall r. ReactComponent (Record r)


multiSelect :: forall r. Record r -> JSX
multiSelect props = element _MultiSelect props

foreign import _MultiSelect        :: forall r. ReactComponent (Record r)

