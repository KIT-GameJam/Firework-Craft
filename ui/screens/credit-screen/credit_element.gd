class_name CreditButton
extends VBoxContainer

signal display_license(credit: CreditEntry)

var credit: CreditEntry

func _ready() -> void:
	$HBoxContainer/LicenseButton.visible = true if credit.license else false

func set_credit(credit_entry: CreditEntry) -> void:
	credit = credit_entry
	if credit.descriptor:
		$DescribtorLabel.text = credit.descriptor
	$HBoxContainer/CreditButton.text = credit.name
	if credit.url:
		$HBoxContainer/CreditButton.pressed.connect(open_url)

func open_url():
	OS.shell_open(credit.url)

func _on_license_button_pressed() -> void:
	display_license.emit(credit)
