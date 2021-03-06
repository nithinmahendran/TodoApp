"""empty message

Revision ID: 1b5e1f58595e
Revises: 589094c4508d
Create Date: 2021-06-15 15:46:40.366261

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '1b5e1f58595e'
down_revision = '589094c4508d'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('tasks', sa.Column('title', sa.String(), nullable=True))
    op.create_unique_constraint(None, 'tasks', ['id'])
    op.create_unique_constraint(None, 'users', ['id'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'users', type_='unique')
    op.drop_constraint(None, 'tasks', type_='unique')
    op.drop_column('tasks', 'title')
    # ### end Alembic commands ###
