import { Button, Input, Modal, ModalBody, ModalFooter, ModalHeader, Popover, PopoverBody, PopoverHeader } from "reactstrap"

function SaveChanges(props: any) {

    let args = {
        centered: true,
        backdrop: true
    }

    return (
        <div>
            <Modal isOpen={props.sending} toggle={props.toggler} {...args}>
                <ModalHeader>
                    Секретный код
                </ModalHeader>
                <ModalBody>
                    <Popover target='group' isOpen={props.error} placement="top" trigger='focus'>
                        <PopoverHeader>
                            Упс! Ошибочки....
                        </PopoverHeader>
                        <PopoverBody>
                            Вы забыли ввести секретный код!
                        </PopoverBody>
                    </Popover>
                    <Input
                        type="number"
                        id="group"
                        placeholder="Код"
                        value={props.code}
                        onChange={props.onCodeChange}
                        onFocus={props.onInputFocus}
                    />
                </ModalBody>
                <ModalFooter>
                    <Button id="btn" onClick={props.sendChanges}>Отправить</Button>
                </ModalFooter>
            </Modal>
        </div>
    )
}

export default SaveChanges