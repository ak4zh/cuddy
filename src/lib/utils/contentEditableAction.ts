export default function contentEditableAction(node, contenteditable: boolean) {
    node.setAttribute('contenteditable', contenteditable);
}