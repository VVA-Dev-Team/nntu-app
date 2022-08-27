import { Button, Input, Label, Modal, ModalBody, ModalFooter, ModalHeader, Popover, PopoverBody, PopoverHeader } from "reactstrap"

function FindGroup(props: any) {

    let args = {
        centered: true
    }

    return (
        <Modal isOpen={props.flag} toggle={props.toggle} {...args} backdrop="static">
            <ModalHeader>
                Название Вашей группы
            </ModalHeader>
            <ModalBody>
                <Popover target='group' isOpen={props.error} placement="top" trigger='focus'>
                    <PopoverHeader>
                        Упс! Ошибочки....
                    </PopoverHeader>
                    <PopoverBody>
                        Вы забыли ввести название группы!
                    </PopoverBody>
                </Popover>
                <Input
                    id="group"
                    placeholder="Название группы"
                    value={props.group}
                    onChange={props.onGroupChange}
                    onFocus={props.onInputFocus}
                />

            </ModalBody>
            <ModalFooter>
                <Button id="btn" onClick={props.saveGroup}>Готово</Button>
            </ModalFooter>
        </Modal>
    )
}

export default FindGroup