class AddAutocompleteInputToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :autocomplete_input, :string, default: nil
  end
end
# la columna autocomplete_input almacena lo que se ingresa como respuesta en la
# pregunta autocompletada